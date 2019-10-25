require 'rails_helper'

describe 'Index page' do
  before(:each) do
    @astronaut = Astronaut.create(name: "Neil Armstrong", age: 37, job: "Commander")
    @astronaut2 = Astronaut.create(name: "Buzz Aldrin", age: 39, job: "Navigator")
  end

  it 'as a visitor I see astronaut info' do
    visit '/astronauts'

    within "#astronaut-#{@astronaut.id}" do
      expect(page).to have_content(@astronaut.name)
      expect(page).to have_content(@astronaut.age)
      expect(page).to have_content(@astronaut.job)
    end

    within "#astronaut-#{@astronaut2.id}" do
      expect(page).to have_content(@astronaut2.name)
      expect(page).to have_content(@astronaut2.age)
      expect(page).to have_content(@astronaut2.job)
    end
  end

  it 'displays the average age of all astronauts' do
    visit '/astronauts'

    avg = (@astronaut.age + @astronaut2.age)/2
    expect(page).to have_content("Average age: #{avg}")
  end

  it 'displays missions in order by astronaut' do
    visit '/astronauts'

    mission1 = @astronaut.missions.create!(title: "Apollo 13", time_in_space: 24)
    mission2 = @astronaut.missions.create!(title: "Capricorn 4", time_in_space: 12)
    mission3 = @astronaut2.missions.create!(title: "Gemini 7", time_in_space: 36)

    within "ul##{@astronaut.id}" do
      expect(page).to have_selector("li:nth-child(1)", text: mission1.title)
      expect(page).to have_selector("li:nth-child(2)", text: mission2.title)
    end

    within "ul##{@astronaut2.id}" do
      expect(page).to have_selector("li:nth-child(1)", text: mission3.title)
    end
  end
end
