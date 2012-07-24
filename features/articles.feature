Feature: Articles
  In order to read the articles on the website
  The articles should be listed on the frontpage and shown on a detail page

  Background:
    Given there are articles
    When I visit the homepage

  Scenario: Viewing the latest articles
    Then I should see the latest articles

  Scenario: Viewing the latest article
    When I select the latest article
    Then I should see the full latest article

  Scenario: Viewing the next-to-last article
    When I select the next-to-last article
    Then I should see the full next-to-last article

  Scenario: Navigating between articles
    When I select the latest article
    Then I should see the full latest article

    When I navigate to the next-to-last article
    Then I should see the full next-to-last article

    When I navigate to the first article
    Then I should only be able to navigate forward

  Scenario: Viewing an article from the carousel
    Then I should see the latest articles
    And I should see the other articles in the carousel

  @allow-rescue
  Scenario: Don't show an unpublished article
    When there is an unpublished article
    And I visit the unpublished article
    Then I should see a 404 error page

  Scenario: Don't include unpublished articles when navigation between them
    When there is an unpublished article
    And I visit the homepage
    Then I should not see the unpublished article on the homepage

    When the unpublished article is published
    And I refresh the page
    Then I should see the previously unpublished article on the homepage
