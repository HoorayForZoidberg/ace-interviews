const broadcastData = (data) => {
  console.log(data);
  fetch('/live_chats', {
    method: 'POST',
    body: JSON.stringify(data),
    headers: { 'content-type': 'application/json' }
  });
};
  
export {
  broadcastData
}

import consumer from './consumer';
import { broadcastData } from './../packs/components/live_chat';
import { currentUser } from './../packs/components/current_user';


const JOIN_ROOM = "JOIN_ROOM";
const EXCHANGE = "EXCHANGE";
const REMOVE_USER = "REMOVE_USER";
const user = currentUser();
let localVideo = document.getElementById('local-video');
const remoteVideo = document.getElementById('remote-video-container');
const ice = { iceServers: [{ urls: "stun:stun.l.google.com:19302" }] };
const joinCta = document.querySelector("#join-meeting");
const leaveCta = document.querySelector("#leave-meeting");
const mainContainer = document.querySelector('#video-chat');
let pcPeers = {};
let localstream;
let subscription;

const createPC = (userId, isOffer) => {
  let pc = new RTCPeerConnection(ice);
  pcPeers[userId] = pc;
  localstream.getTracks().forEach((track) => {
    pc.addTrack(track, localstream);
  });
  isOffer &&
    pc.createOffer()
      .then((offer) => {
        pc.setLocalDescription(offer).then(() => {
          setTimeout( () => {
            broadcastData({
              live_chat: {
                type: EXCHANGE,
                from: user,
                to: userId,
                sdp: JSON.stringify(pc.localDescription)
              }
            });
          }, 0);
        });
      })
      .catch((error) => console.warn(error));
  pc.onicecandidate = (event) => {
    event.candidate &&
      broadcastData({
        live_chat: {
          type: EXCHANGE,
          from: user,
          to: userId,
          candidate: JSON.stringify(event.candidate)
        }
      });
  };

  pc.ontrack = (event) => {
    const row = document.createElement('div');
    row.className = 'col-6 col-md-3';
    const video = document.createElement('video');
    video.id = `remoteVideoContainer_${userId}`;
    video.autoplay = 'autoplay';
    video.srcObject = event.streams[0];
    video.className = 'w-100 remote-video';
    const videoExists = document.querySelector(`#remoteVideoContainer_${userId}`)
    if (videoExists) {
      const parentDiv = videoExists.parentElement;
      parentDiv.removeChild(videoExists);
      parentDiv.appendChild(video);
    } else {
      row.appendChild(video);
      remoteVideo.appendChild(row);
    }
  };

  pc.oniceconnectionstatechange = (event) => {
    if (pc.iceConnectionState == 'disconnected') {
      console.log("Disconnected", userId);
      broadcastData({
        live_chat: {
          type: REMOVE_USER,
          from: userId
        }
      });
    };
  };
  return pc;
}

const joinRoom = (data) => {
  createPC(data.from, true);
};

const exchange = (data) => {
  let pc;
  if (pcPeers[data.from]) {
    pc = pcPeers[data.from];
  } else {
    pc = createPC(data.from, false);
  }

  if (data.candidate) {
    let candidate = JSON.parse(data.candidate);
    pc.addIceCandidate(new RTCIceCandidate(candidate))
      .then(() => console.log("Ice candidate added"))
      .catch((error) => console.warn(error));
  }

  if (data.sdp) {
    let sdp = JSON.parse(data.sdp);
    console.log(sdp && !sdp.candidate);
    if (sdp && !sdp.candidate) {
      pc.setRemoteDescription(new RTCSessionDescription(sdp))
        .then(() => {
            if (sdp.type === 'offer') {
              pc.createAnswer().then((answer) => {
                pc.setLocalDescription(answer).then(() => {
                  broadcastData({
                    live_chat: {
                      type: EXCHANGE,
                      from: user,
                      to: data.from,
                      sdp: JSON.stringify(pc.localDescription)
                    }
                  });
                });
              });
            }
        }).catch((error) => console.warn(error));
    }
  }
}

const removeUser = (data) => {
  console.log("removing user", data.from);
  let video = document.querySelector(`#remoteVideoContainer_${data.from}`);
  video && video.parentElement.remove();
  delete pcPeers[data.from];
}

const handleLeaveSession = async () => {
  for (let u in pcPeers) {
    pcPeers[u].close();
  }

  pcPeers = {};

  consumer.subscriptions.remove(subscription);
  const remoteVideos = document.querySelectorAll('.remote-video');
  remoteVideos.forEach((video) => {
    video.parentElement.remove();
  });
  await broadcastData({
    live_chat: {
      type: REMOVE_USER,
      from: user
    }
  });
  leaveCta.classList.add('d-none');
  joinCta.classList.remove('d-none');
}
document.addEventListener('turbolinks:load', () => {
  if (localVideo && remoteVideo && user) {
    if (document.readyState === 'interactive') {
      navigator.mediaDevices.getUserMedia({
        audio: true,
        video: true
      }).then((stream) => {
        localstream = stream;
        localVideo.srcObject = stream;
        localVideo.muted = true;
      }).catch((error) => {
        console.warn(error);
      });
      joinCta.addEventListener('click', () => {
        joinCta.classList.add('d-none');
        leaveCta.classList.remove('d-none');
        subscription = consumer.subscriptions.create({ channel: 'LiveChatChannel' }, {
          connected() {
            broadcastData({ live_chat: { type: JOIN_ROOM, from: user }})
          },
          received(data) {
            console.log("RECEIVED:", data);
            if (data.from === user) return;
            switch (data.type) {
              case JOIN_ROOM:
                return joinRoom(data);
              case EXCHANGE:
                if (data.to !== user) return;
                return exchange(data);
              case REMOVE_USER:
                return removeUser(data);
              default:
                return;
            }
          },
          disconnected() {
            console.log('disconnected');
          }
        });
      });
      leaveCta.addEventListener('click', handleLeaveSession);
    }
  }
});