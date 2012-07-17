Feature: Articles
  In order to read the articles on the website
  The articles should be listed on the frontpage and shown on a detail page

  Scenario: Viewing the latest articles
    Given there are articles
    When I visit the homepage
    Then I should see the latest articles

  Scenario: Viewing an article
    Given there are articles
    When I select the latest article
    Then I should see the full article

  Scenario: Viewing the list of articles
    Given there are more articles than the latest articles
    When I visit the homepage
    Then I should see the latest articles
    And I should see the other articles in the carousel
