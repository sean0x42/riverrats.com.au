document.addEventListener("ajax:error", (event) => {
  const [ , status,  ] = event.detail;

  switch (status) {
    case "Forbidden":
      createFlash("Unauthorized.", "Sorry, you don't have permission to perform that action.");
      closeModal();
      break;
  }
});
