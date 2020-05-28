import flatpickr from "flatpickr";

document.addEventListener('turbolinks:load', () => {
  if (document.querySelector(".datepicker")) {
    flatpickr(".datepicker", {enableTime: true, dateFormat: "Y-m-d H:i", minDate: "today", inline: true});
  }
});
