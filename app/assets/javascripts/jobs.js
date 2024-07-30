document.addEventListener("turbo:load", function() {
  const searchField = document.getElementById('search-field');

  if (searchField) {
    searchField.addEventListener('input', function() {
      const query = searchField.value;
      const xhr = new XMLHttpRequest();
      xhr.open('GET', `/jobs?search=${encodeURIComponent(query)}`, true);
      xhr.setRequestHeader('Accept', 'text/javascript');
      xhr.onload = function () {
        if (xhr.status >= 200 && xhr.status < 400) {
          // Assuming the response is the HTML for the table
          document.getElementById('jobs-list').innerHTML = xhr.responseText;
        }
      };
      xhr.send();
    });
  }
});
