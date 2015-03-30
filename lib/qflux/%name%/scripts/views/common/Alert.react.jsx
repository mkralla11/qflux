var React = require('react');
var BaseUtils = require('../../utils/UtilFuncs.coffee');

var Alert = React.createClass({
  renderAlert: function(){
    var classes = this.props.alertClass || "alert-danger";
    classes += " alert-dismissible alert";
    return (
      <div className={classes} role="alert">
        <button type="button" className="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true" onClick={ this.props.clearMessages }>&times;</span>
        </button>
          {BaseUtils.wrap(this.props.messages).map(function(m, index){
            return <p className="message-p" key={"message-"+index}>{m}</p>;
          })}
      </div>
    );
  },


  render: function() {
    return this.props.messages.length ? this.renderAlert() : <div></div>;
  }
});

module.exports = Alert;

