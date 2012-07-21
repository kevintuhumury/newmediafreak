Feature: Error pages

  @allow-rescue
  Scenario: Show a custom 404 page when a page can't be found
    Given there is an article
    When I visit that article
    Then I should not see a custom 404 error page

    When I visit a non-existing article
    Then I should see a custom 404 error page
