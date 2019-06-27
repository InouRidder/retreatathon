
function gipher() {
  const url = 'https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC';
  document.querySelectorAll('.product-thumbnail').forEach(img => {
    if (!img.src.includes('upload')) {
      fetch(url)
        .then(res => res.json())
        .then(data => {
        console.log(data.data)
      img.style.backgroundImage = `url(${data.data.fixed_width_small_url})`})
        .catch(error => console.log(error));

    }
  })

}


export { gipher };
