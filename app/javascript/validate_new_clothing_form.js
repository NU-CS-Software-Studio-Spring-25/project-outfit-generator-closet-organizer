document.addEventListener("DOMContentLoaded", () => {

  const form = document.querySelector(".clothing-form");
  if (!form) return;

  form.addEventListener("submit", (e) => {

    const name = form.querySelector("#clothing_name");
    const category = form.querySelector("#clothing_category");
    const articleTop = form.querySelector("#article-top");
    const articleBottom = form.querySelector("#article-bottom");
    const image = form.querySelector("#clothing_image");

    let hasError = false;
    let messages = [];

    if (!name?.value.trim()) {
      hasError = true;
      messages.push("Name is required.");
    }

    if (!category?.value.trim()) {
      hasError = true;
      messages.push("Category is required.");
    }

    if (!articleTop?.checked && !articleBottom?.checked) {
      hasError = true;
      messages.push("You must choose an article type.");
    }

    if (!image?.value.trim()) {
      hasError = true;
      messages.push("Image is required.");
    }

    if (hasError) {
      e.preventDefault();
      alert(messages.join("\n"));
    }
  });
});
