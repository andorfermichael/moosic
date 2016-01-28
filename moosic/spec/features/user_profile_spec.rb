require 'spec_helper'

feature 'user profile content and features', type: :feature do
  scenario 'user profile lists playlists created by the logged in user' do
    create(:user)
    create(:playlist)
    FactoryGirl.create(:playlist, name: 'Chillout', user_id: 1, created_at: DateTime.new(2016, 1, 2).in_time_zone)
    FactoryGirl.create(:playlist, name: 'Progressive House', user_id: 2, created_at: DateTime.new(2016, 1, 2).in_time_zone)
    create(:song)
    create(:song, titel: 'Payback',
                  source: 'Dimitri Vangelis & Wyman',
                  thumbnail_url: '',
                  song_url: '147229671',
                  host: 'soundcloud',
                  year: DateTime.new(2015, 12, 4).in_time_zone)
    create(:song,
           titel: 'WILD - Back To You',
           source: 'MrSuicideSheep',
           thumbnail_url: 'https://i.ytimg.com/vi/HtcWvsiQkZE/mqdefault.jpg',
           song_url: 'HtcWvsiQkZE',
           host: 'youtube',
           year: DateTime.new(2015, 12, 4).in_time_zone)
    create(:track)
    create(:track, position: 2, playlist_id: 1, song_id: 2)
    create(:track, position: 1, playlist_id: 2, song_id: 3)

    visit root_path
    within('.input-container') do
      fill_in 'session_email', with: 'john.doe@example.com'
      fill_in 'session_password', with: 'Very2trongPa22w0rd!'
    end
    click_button 'Log in'

    expect(first("a[href='/playlists/1']")).to have_content 'EDM'
    expect(first("a[href='/playlists/1']")).to have_content 'created on 02.01.2016'
    expect(first("a[href='/playlists/1']")).to have_content '2 songs'

    expect(first("a[href='/playlists/2']")).to have_content 'Chillout'
    expect(first("a[href='/playlists/2']")).to have_content 'created on 02.01.2016'
    expect(first("a[href='/playlists/2']")).to have_content '1 songs'

    expect(page).not_to have_content 'Progressive House'
  end

  scenario 'user profile contains correct number of playlists' do
    create(:user)
    create(:playlist)
    FactoryGirl.create(:playlist, name: 'Chillout', user_id: 1)
    FactoryGirl.create(:playlist, name: 'Progressive House', user_id: 1)

    visit root_path
    within('.input-container') do
      fill_in 'session_email', with: 'john.doe@example.com'
      fill_in 'session_password', with: 'Very2trongPa22w0rd!'
    end
    click_button 'Log in'

    expect(page).to have_content 'playlists: 3'
  end

  scenario 'user profile contains correct year of user signup' do
    create(:user, email: 'michael.pattern@example.com', created_at: DateTime.new(2015, 1, 1).in_time_zone)

    visit root_path
    within('.input-container') do
      fill_in 'session_email', with: 'michael.pattern@example.com'
      fill_in 'session_password', with: 'Very2trongPa22w0rd!'
    end
    click_button 'Log in'

    expect(page).to have_content 'member since: 2015'
  end

  scenario 'user profile contains correct username' do
    user = create(:user)

    visit root_path
    within('.input-container') do
      fill_in 'session_email', with: 'john.doe@example.com'
      fill_in 'session_password', with: 'Very2trongPa22w0rd!'
    end
    click_button 'Log in'

    expect(page).to have_content user.name.downcase
  end

  scenario 'user profile contains placeholder image in top bar' do
    create(:user)

    visit root_path
    within('.input-container') do
      fill_in 'session_email', with: 'john.doe@example.com'
      fill_in 'session_password', with: 'Very2trongPa22w0rd!'
    end
    click_button 'Log in'

    expect(page.find('.img-circle-small')['src']).to eq('http://gravatar.com/avatar/8eb1b522f60d11fa897de1dc6351b7e8?default=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fen%2Fb%2Fb1%2FPortrait_placeholder.png&secure=false&size=512')
  end

  scenario 'user profile contains placeholder image in sidebar' do
    create(:user)

    visit root_path
    within('.input-container') do
      fill_in 'session_email', with: 'john.doe@example.com'
      fill_in 'session_password', with: 'Very2trongPa22w0rd!'
    end
    click_button 'Log in'

    expect(page.find('.img-circle-big')['src']).to eq('http://gravatar.com/avatar/8eb1b522f60d11fa897de1dc6351b7e8?default=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fen%2Fb%2Fb1%2FPortrait_placeholder.png&secure=false&size=512')
  end
end
