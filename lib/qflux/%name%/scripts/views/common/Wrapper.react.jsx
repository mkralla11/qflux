var React = require('react');

var Wrapper = React.createClass({
  render: function() {
    return this.props.children;
  }
});

module.exports = Wrapper;

