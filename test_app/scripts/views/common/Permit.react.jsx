var Permit = React.createClass({
  render: function() {
    if (window[this.props.policy].permit(this.props.action, this.props.record)) {
      return this.props.children;
    } else {
      return null;
    }
  }
});