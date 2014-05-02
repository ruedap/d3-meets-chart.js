describe 'Chart.Util', ->
  'use strict'

  describe '.alpha', ->
    it 'should return a string', ->
      expect(Chart.Util.alpha('#336699', 0.5)).to.be('rgba(51,102,153,0.5)')

  describe '.extend', ->
    context 'when 2 arguments', ->
      it 'should return a merged object', ->
        extend = Chart.Util.extend
        expect(extend({}, {a: 1, b: 2})).to.eql({a: 1, b: 2})
        expect(extend({a: 1, b: 2}, {})).to.eql({a: 1, b: 2})
        expect(extend({a: 1}, {b: 2})).to.eql({a: 1, b: 2})

    context 'when 3 arguments', ->
      it 'should return a merged object', ->
        extend = Chart.Util.extend
        expect(extend({}, {a: 1}, {b: 2})).to.eql({a: 1, b: 2})
        expect(extend({a: 1}, {b: 2}, {})).to.eql({a: 1, b: 2})
        expect(extend({a: 1}, {}, {b: 2})).to.eql({a: 1, b: 2})

  describe '.is', ->
    it 'should return a boolean', ->
      expect(Chart.Util.is('String', 'foo')).to.be.ok()
      expect(Chart.Util.is('String', 1)).not.to.be.ok()
      expect(Chart.Util.is('Number', 'foo')).not.to.be.ok()
      expect(Chart.Util.is('Number', 0)).to.be.ok()
