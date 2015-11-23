var ExpensesStuff = ExpensesStuff || {};

ExpensesStuff.expensesHelper = function(){
  var bindToggleForm = function() {
    $('[data-toggle-add-expense]').on('click', function() {
      $('[data-add-expense]').toggleClass('is-hidden');

      var $form = $('[data-expense-form]');
      $form.toggleClass('is-hidden');
      clearInputs($form);
    });
  };

  var clearInputs = function($form) {
    $form.find(':input').not(':button, :submit, :reset, :hidden')
      .val('')
      .removeAttr('checked')
      .removeAttr('selected');
  }

  return {
    initialize: function() {
      bindToggleForm();
    }
  }
}();

$(document).on('ready, page:load, page:change', function(){
  ExpensesStuff.expensesHelper.initialize();
});
