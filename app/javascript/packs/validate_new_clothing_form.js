document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector(".clothing-form");
    if (!form) return;
  
    form.addEventListener("submit", (e) => {
      const name = form.querySelector("input[name='clothing[name]']");
      const category = form.querySelector("input[name='clothing[category]']");
      const articleTop = form.querySelector("#article-top");
      const articleBottom = form.querySelector("#article-bottom");
      const image = form.querySelector("input[name='clothing[image]']");
  
      let hasError = false;
      let messages = [];
  
      if (!name.value.trim()) {
        hasError = true;
        messages.push("Name is required.");
      }
  
      if (!category.value.trim()) {
        hasError = true;
        messages.push("Category is required.");
      }
  
      if (!articleTop.checked && !articleBottom.checked) {
        hasError = true;
        messages.push("You must choose an article type.");
      }
  
      if (!image.value && form.classList.contains("new_record")) {
        hasError = true;
        messages.push("An image is required.");
      }
  
      if (hasError) {
        e.preventDefault();
        alert(messages.join("\n"));
      }
    });
  });
  