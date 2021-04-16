import { inputChangeSelector } from "@rails/ujs";
import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `<p>${data.content.text}</p>`;
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('message_text')
    document.getElementById('send').removeAttribute('disabled');
    messages.insertAdjacentHTML('afterbegin', html);
    newMessage.value='';
  }
});
