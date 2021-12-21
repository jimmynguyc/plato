export const getMetaValue = (name) => {
  const element = document.head.querySelector(`meta[name="${name}"]`);
  return element.getAttribute("content");
};


export const patch = (path, formData) => fetch(path, {
      body: formData,
      method: "PATCH",
      dataType: "script",
      credentials: "include",
      headers: {
        "X-CSRF-Token": getMetaValue("csrf-token"),
      },
    })
