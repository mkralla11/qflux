var React = require('react');
var Wrapper = ('Wrapper.react.jsx');
// var assign = require('object-assign');
var classNames = require('classnames');

var BasicErrorField = React.createClass({
  // getInitialState: function() {
  //   return { 
  //     targetErrors: []
  //   };
  // },
  getDefaultProps: function(){
    return {
      errors: [],
      targetErrors: [],
      name: "unknown",
      dismissErrorFor: function(){}
    }
  },

  // componentWillReceiveProps: function(nextProps){
  //   this.setState({
  //     targetErrors: []
  //   })
  // },
  dissmiss: function(){
    this.props.dismissErrorFor(this.props.name);
  },


  renderErrors: function(targetErrors){
    var self = this;
    return (      
      <div className="tooltip bottom in c-pointer basic-error-field-tooltip" role="tooltip" onClick={this.dissmiss}>
        <div className="tooltip-arrow"></div>
        <div className="tooltip-inner">
          {targetErrors.map(function(err, index){
            return (
              <p>
                {self.props.name} {err}
              </p>
            );
          })}
        </div>
      </div>
    )
  },


  render: function() {
    var targetErrors = this.props.errors[this.props.name];
    return (      
      <Wrapper {...this.props} className={this.props.className + " errorWrapper" }>
        {this.props.children }
        {targetErrors ? this.renderErrors(targetErrors) : null}
      </Wrapper>
    )
  }
});

module.exports = BasicErrorField;

