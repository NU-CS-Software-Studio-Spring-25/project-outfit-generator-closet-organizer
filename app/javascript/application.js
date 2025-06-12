// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "./validate_new_clothing_form"
import "chartkick"
import "Chart.bundle"
Rails.start()

document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("new_clothing_form");
  
    if (form) {
      form.addEventListener("submit", function (event) {
        const name = document.getElementById("clothing_name").value.trim();
        const category = document.getElementById("clothing_category").value.trim();
        const articleTop = document.getElementById("article-top").checked;
        const articleBottom = document.getElementById("article-bottom").checked;
  
        if (!name || !category || (!articleTop && !articleBottom)) {
          event.preventDefault();
          alert("Please fill out Name, Category, and choose an Article type.");
        }
      });
    }
  });
  
  