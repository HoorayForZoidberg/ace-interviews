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
