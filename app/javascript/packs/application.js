import "bootstrap";
import Choices from 'choices.js'
import autoComplete from "@tarekraafat/autocomplete.js";
import "@tarekraafat/autocomplete.js/dist/css/autoComplete.css";
import { suggestionsController } from '../controllers/suggestionsController.js'

import Rails from 'rails-ujs';
Rails.start();

suggestionsController.initialize();

//const choices = new Choices(element);

new autoComplete({
  data: {
      src: async () => {
          var query = document.querySelector("#autoComplet").value;

          // Fetch External Data Source
          const source = await fetch(`/autocomplete?q=${query}`);
          // Format data into JSON

          const data = await source.json();
          // Return Fetched data
          return data.products;
      },
      key: ["title"],
      cache: false
  },
  placeHolder: "product name, team members, city...",     // Place Holder text                 | (Optional)
  selector: "#autoComplet",           // Input field selector              | (Optional)
  threshold: 2,                        // Min. Chars length to start Engine | (Optional)
  debounce: 300,                       // Post duration for engine to start | (Optional)
  searchEngine: "strict",              // Search Engine type/mode           | (Optional)
  resultsList: {                       // Rendered results list object      | (Optional)
      render: true,
      container: source => {
          var resultsListID = "products_List";
          return resultsListID;
      },
      destination: document.querySelector("#autoComplet"),
      position: "afterend",
      element: "ul"
  },
  maxResults: 5,                         // Max. number of rendered results | (Optional)
  highlight: true,                       // Highlight matching results      | (Optional)
  resultItem: {                          // Rendered result item            | (Optional)
      content: (data, source) => {
          source.innerHTML = data.match;
      },
      element: "li"
  },
  noResults: () => {                     // Action script on noResults      | (Optional)
      const result = document.createElement("li");
      result.setAttribute("class", "no_result");
      result.setAttribute("tabindex", "1");
      result.innerHTML = "No Results";
      document.querySelector("#autoComplete_results_list").appendChild(result);
  },
  onSelection: feedback => {
    console.log('On select', feedback.selection.value);
    document.querySelector("#autoComplet").value = feedback.selection.value;
    Rails.fire(document.querySelector("#searchForm"), 'submit');
  }
});
