document.addEventListener('DOMContentLoaded', () => {
  const searchInput = document.getElementById('search-field');

  if (searchInput) {
    searchInput.addEventListener('input', () => {
      const query = searchInput.value;
      const xhr = new XMLHttpRequest();
      xhr.open('GET', `/jobs?search=${encodeURIComponent(query)}`, true);
      xhr.setRequestHeader('Accept', 'text/javascript');
      xhr.onload = function () {
        if (xhr.status >= 200 && xhr.status < 400) {
          document.getElementById('jobs-list').innerHTML = xhr.responseText;
        }
      };
      xhr.send();
    });
  }
});
