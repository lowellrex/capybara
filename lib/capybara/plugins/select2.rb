module Capybara
  module Plugins
    class Select2
      def select(scope, value, from: nil, **options)
        select = if from
          scope.find(:select, from, options.merge(visible: false))
        else
          scope.find(:option, value, options).ancestor(:css, 'select', visible: false)
        end

        # open the select2 dropdown
        select.sibling(:css, '.select2-container').click
        results = scope.find(:xpath, XPath.anywhere(:ul)[XPath.attr(:class).contains_word('select2-results__options')][XPath.attr(:id)])

        result = results.find(:css, 'li.select2-results__option[role=treeitem]', text: value)
        result.click
      end
    end
  end
end

Capybara.add_selector(:select2_dropdown) do
end

Capybara.add_selector(:select2_option) do
end

Capybara.register_plugin(:select2, Capybara::Plugins::Select2.new)