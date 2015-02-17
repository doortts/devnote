Browser = require 'zombie'
assert = require 'assert'
app = require '../app.coffee'
url = require 'url'

port = 3000
getUrl = (pathname) -> url.format
  protocol: 'http:',
  hostname: 'localhost',
  port: port,
  pathname: pathname,

suite '웹 인터페이스', ->
  browser = {}

  suiteSetup (done) ->
    app.start port, done

  setup (done) ->
    browser = new Browser
    browser.runScripts = false
    done()

  test '새 페이지 등록하기 - POST /wikis/note/pages/:name', (done) ->
    browser.visit getUrl('/wikis/note/new'), ->
      assert.ok browser.success
      browser.
        fill('name', 'FrontPage').
        fill('body', 'Welcome to n4wiki!').
        pressButton 'save', ->
          assert.ok browser.success
          assert.equal browser.text('.nBody .page-header h1'), 'FrontPage'
          assert.equal browser.text('.nBody article.tx'), 'Welcome to n4wiki!'
          done()

  test '등록한 페이지 열어보기 - GET /wikis/note/pages/:name', (done) ->
    browser.visit getUrl('/wikis/note/new'), ->
      assert.ok browser.success
      browser.
        fill('name', 'FrontPage').
        fill('body', 'Welcome to n4wiki!').
        pressButton 'save', ->
          browser.visit getUrl('/wikis/note/pages/FrontPage'), ->
            assert.ok browser.success
            assert.equal browser.text('.nBody .page-header h1'), 'FrontPage'
            assert.equal browser.text('.nBody article.tx'), 'Welcome to n4wiki!'
            done()

  test '등록하지 않은 페이지 열어보기 - GET /wikis/note/pages/:name', (done) ->
    browser.visit getUrl('/wikis/note/new'), ->
      assert.ok browser.success, '페이지 편집 폼을 가져와야 한다'
      browser.
        fill('name', 'FrontPage').
        fill('body', 'Welcome to n4wiki!').
        pressButton 'save', ->
          browser.visit getUrl('/wikis/note/pages/FrontPage2'),
            (e, browser, status) ->
              assert.equal status, 404, 'The status code should be 404, but ' + status + '.'
              done()

  test '등록한 페이지 편집하기 - GET /wikis/note/pages/:name?action=edit', (done) ->
    browser.visit getUrl('/wikis/note/new'), ->
      assert.ok browser.success
      browser.
        fill('name', 'FrontPage').
        fill('body', 'Welcome to n4wiki!').
        pressButton 'save', ->
          browser.visit getUrl('/wikis/note/pages/FrontPage?action=edit'), ->
            assert.ok browser.success
            browser.
              fill('name', 'FrontPage').
              fill('body', 'n4wiki updated!').
              pressButton 'save', ->
                browser.visit getUrl('/wikis/note/pages/FrontPage'), ->
                  assert.ok browser.success
                  assert.equal browser.text('.nBody .page-header h1'), 'FrontPage'
                  assert.equal browser.text('.nBody article.tx'), 'n4wiki updated!'
                  done()

  test '등록한 페이지 삭제하기 - DELETE /wikis/note/pages/:name', (done) ->
    browser.visit 'http://localhost:3000/wikis/note/new', ->
      browser.
        fill('name', 'FrontPage').
        fill('body', 'Welcome to n4wiki!').
        pressButton 'save', ->
          browser.visit 'http://localhost:3000/wikis/note/pages/FrontPage', ->
              browser.pressButton 'submit', ->
                browser.visit "http://localhost:3000/wikis/note/pages/FrontPage",
                  (e, browser, status) ->
                    assert.equal status, 404, 'The status code should be 404, but ' + status + '.'
                    done()

  suiteTeardown (done) ->
    app.stop()
    done()
