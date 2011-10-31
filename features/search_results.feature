Feature: Search Results

    Scenario: Search for welfare
        Given I am on the home page
        When I fill in the search box with "welfare"
        And I press "search"
        Then I should have fewer results than a search for ""

  
  Scenario: Submitting a Search
    When I am on the home page
    And I fill in "q" with "history"
    And I select "All Fields" from "search_field"
    And I press "search"
    Then I should be on "the catalog page"
    And I should see an rss discovery link
    And I should see an atom discovery link
    And I should see opensearch response metadata tags
    And I should see "You searched for:"
    And I should see "All Fields"
    And I should see "history"
    And I should see select list "select#search_field" with "All Fields" selected
    And I should see "per page"
    And I should see a selectable list with per page choices
    And I should see "1."
    And I should see "2."
    And I should see "3."
    And I should see "Sort by"
    
    Scenario: Searching for Bill in Contributor
        Given I am on the home page
        When I select "Contributor" from "search_field"
        And I fill in the search box with "Bill"
        And I press "search"
        Then I should see "You searched for:"

