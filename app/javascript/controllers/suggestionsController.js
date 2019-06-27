const suggestionsController= {
  initialize: function() {
    this.input = document.querySelector('.suggestable');
    if (!this.input) return;
    this.suggestions = JSON.parse(this.input.dataset.suggestions);
    this.input.addEventListener('keyup', this.suggest.bind(this))
    this.suggestionsElement = document.querySelector('.suggestions');
  },

  suggest: function() {
    if (this.input.value === '') {
      this.suggestionsElement.innerHTML = '';
      return;
    }
    const query = this.activeTag(this.input.value);
    const foundSuggestions = this.suggestions.filter(suggestion => {
      return suggestion.includes(query.toLowerCase())
    })
    this.insertSuggestions(foundSuggestions.slice(1,10))
  },

  insertSuggestions: function(suggestions) {
    const suggestElement = document.querySelector('.suggestions');
    suggestElement.innerHTML = ''
    suggestions.forEach(suggestion => {
      const template = `<li class='suggestion autoComplete_result'>${suggestion}</li>`
      suggestElement.insertAdjacentHTML('afterbegin', template)
    })
    this.setListeners()
  },

  setListeners: function() {
    document.querySelectorAll('.suggestion').forEach(suggestion => {
      suggestion.addEventListener('click', () => {

        let currentTags = this.input.value.split(' ')
        currentTags.pop()
        currentTags.push(suggestion.innerText)
        this.input.value = currentTags.join(' ')
        document.querySelector('.suggestions').innerHTML = ''
        document.getElementById('searchForm').submit();
      })
    })
  },

  activeTag: function(formValue) {
    let activeTags = formValue.split(" ")
    return activeTags[activeTags.length - 1]
  },

}

export { suggestionsController };



