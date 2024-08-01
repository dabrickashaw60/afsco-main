document.addEventListener('DOMContentLoaded', function () {
  var checkboxes = document.querySelectorAll('.material-checkbox');
  var typeOfWorkField = document.getElementById('type_of_work_field');

  checkboxes.forEach(function (checkbox) {
    checkbox.addEventListener('change', updateTypeOfWorkField);
  });

  function updateTypeOfWorkField() {
    var selectedMaterials = [];
    checkboxes.forEach(function (checkbox) {
      if (checkbox.checked) {
        selectedMaterials.push(checkbox.value);
      }
    });
    typeOfWorkField.value = selectedMaterials.join(', ');
  }
});