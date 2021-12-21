import { Controller } from "@hotwired/stimulus";
import { patch } from "../utils";

export default class extends Controller {
  click(event) {
    const element = event.currentTarget;
    const updatePath = event.params.path;
    const formData = new FormData();

    formData.append("task[completed]", element.checked);

    patch(updatePath, formData).then((response) => {
      if (response.status != 204) {
        element.checked = !element.checked;
      }
    });
  }
}
