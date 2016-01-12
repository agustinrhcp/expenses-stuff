var ExpensesStuff = ExpensesStuff || {};

ExpensesStuff.expensesHelper = function(){
  var bindToggleOptions = function(e) {
    $('[data-toggle-expenses-options]').on('click', function(e) {
      e.preventDefault();

      $('[data-expenses-options]').toggleClass('hide');
    });
  };

  return {
    initialize: function() {
      bindToggleOptions();
    }
  };
}();

$(document).on('ready, page:load, page:change', function(){
  ExpensesStuff.expensesHelper.initialize();
});
