var ExpensesStuff = ExpensesStuff || {};

ExpensesStuff.expensesHelper = function(){
	var bindToggleForm = function() {
		$('[data-toggle-add-expense]').on('click', function() {
			$('[data-expense-form]').toggleClass('is-hidden');
			$('[data-add-expense]').toggleClass('is-hidden');
		});
	};

	return {
		initialize: function() {
			bindToggleForm();
		}
	}
}();

$(document).on('ready, page:load, page:change', function(){
	ExpensesStuff.expensesHelper.initialize();
});
