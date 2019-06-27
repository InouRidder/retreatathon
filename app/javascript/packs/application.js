import "bootstrap";
import Choices from 'choices.js'
import autoComplete from "@tarekraafat/autocomplete.js";
import "@tarekraafat/autocomplete.js/dist/css/autoComplete.css";

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
    document.querySelector("#searchForm").submit();
  }
});

const choices = new Choices('.choice', {
    silent: false,
    items: [],
    choices: [],
    renderChoiceLimit: -1,
    maxItemCount: -1,
    addItems: true,
    addItemFilterFn: null,
    removeItems: true,
    removeItemButton: false,
    editItems: false,
    duplicateItemsAllowed: true,
    delimiter: ',',
    paste: true,
    searchEnabled: true,
    searchChoices: true,
    searchFloor: 1,
    searchResultLimit: 4,
    searchFields: ['label', 'value'],
    position: 'auto',
    resetScrollPosition: true,
    shouldSort: true,
    shouldSortItems: false,
    placeholder: true,
    placeholderValue: null,
    searchPlaceholderValue: null,
    prependValue: null,
    appendValue: null,
    renderSelectedChoices: 'auto',
    loadingText: 'Loading...',
    noResultsText: 'No results found',
    noChoicesText: 'No choices to choose from',
    itemSelectText: 'Press to select',
    addItemText: (value) => {
      return `Press Enter to add <b>"${value}"</b>`;
    },
    maxItemText: (maxItemCount) => {
      return `Only ${maxItemCount} values can be added`;
    },
    itemComparer: (choice, item) => {
      return choice === item;
    },
    classNames: {
      containerOuter: 'choices',
      containerInner: 'choices__inner',
      input: 'choices__input',
      inputCloned: 'choices__input--cloned',
      list: 'choices__list',
      listItems: 'choices__list--multiple',
      listSingle: 'choices__list--single',
      listDropdown: 'choices__list--dropdown',
      item: 'choices__item',
      itemSelectable: 'choices__item--selectable',
      itemDisabled: 'choices__item--disabled',
      itemChoice: 'choices__item--choice',
      placeholder: 'choices__placeholder',
      group: 'choices__group',
      groupHeading: 'choices__heading',
      button: 'choices__button',
      activeState: 'is-active',
      focusState: 'is-focused',
      openState: 'is-open',
      disabledState: 'is-disabled',
      highlightedState: 'is-highlighted',
      hiddenState: 'is-hidden',
      flippedState: 'is-flipped',
      loadingState: 'is-loading',
      noResults: 'has-no-results',
      noChoices: 'has-no-choices'
    },
    // Choices uses the great Fuse library for searching. You
    // can find more options here: https://github.com/krisk/Fuse#options
    fuseOptions: {
      include: 'score'
    },
    callbackOnInit: null,
    callbackOnCreateTemplates: null
  });