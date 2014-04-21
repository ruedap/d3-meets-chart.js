describe 'Chart.Util', ->
  'use strict'

  describe '.is', ->
    it 'should return a boolean', ->
      expect(Chart.Util.is('String', 'foo')).to.be.ok()
      expect(Chart.Util.is('String', 1)).not.to.be.ok()
      expect(Chart.Util.is('Number', 'foo')).not.to.be.ok()
      expect(Chart.Util.is('Number', 0)).to.be.ok()
