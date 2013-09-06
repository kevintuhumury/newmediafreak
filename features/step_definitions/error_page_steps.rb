Then "I should not see a custom 404 error page" do
  within "#content #single-article .article" do
    should have_selector ".title h2", text: "An article"
  end

  expect(page).to have_no_selector ".error #not_found #message h1", text: "Uhoh..."
  expect(page).to have_no_selector ".error #not_found #message p"

  expect(page).to have_no_content '"404: File not found" oftewel de pagina waar je naar op zoek bent bestaat niet. Het lijkt erop dat je verdwaald bent in een galaxy far, far away...'
end

When "I visit a non-existing article" do
  visit "/a-non-existing-article"
end

Then "I should see a custom 404 error page" do
  within ".error #not_found #message" do
    should have_selector "h1", text: "Uhoh..."
    should have_content '"404: File Not Found" oftewel de pagina waar je naar op zoek bent bestaat niet. Het lijkt erop dat je verdwaald bent in een galaxy far, far away...'
    should have_content "...dus ga terug naar de Melkweg. Err, New Media Freak"
  end
end
