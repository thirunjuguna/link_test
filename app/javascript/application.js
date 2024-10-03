// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

import "trix";
import "@rails/actiontext";

document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll("a").forEach(function (url) {
    url.addEventListener("click", function (event) {
      const href = event.target.href;
      const anchorText = event.target.innerText;
      const authenticationToken = document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content");

      const payload = {
        url: href,
        anchor_text: anchorText,
        authentication_token: authenticationToken,
      };

      const headers = {
        type: "application/json",
      };

      const data = new Blob([JSON.stringify(payload)], headers);

      navigator.sendBeacon("/link_clicks", data);
    });
  });
});
