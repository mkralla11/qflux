var React = require('react');
var BaseUtils = require('../../utils/UtilFuncs.coffee');
var classNames = require('classnames');
var assign = require('object-assign');

var Bouncer = React.createClass({
  propTypes: {
    isBouncing: React.PropTypes.bool.isRequired
  },
  getDefaultProps: function() {
    return {
      isBouncing: false,
      className: ""
    };
  },

  renderBouncer: function(){
    var classes = this.props.className + " bouncer";

    return (
      <div className={classes}>
        <div></div>
      </div>
    );
  },


  render: function() {
    return this.props.isBouncing ? this.renderBouncer() : null;
  }
});

module.exports = Bouncer;

