var React = require('react');
var classNames = require('classnames');
var cloneWithProps = require('react-clonewithprops');
var UF = require('../../Utils/utilFuncs.coffee');

var Dropdown = React.createClass({
  getInitialState: function() {
    return { 
      open: this.props.initialOpen || false
    };
  },
  getDefaultProps: function() {
    return {
      baseElement: 'li',
      toggleLink: null,
      dropDownList: null,
      Items: null
    };
  },

  _toggleDropdown: function(){
    this.setState({open: !this.state.open});
  },
  _closeDropdown: function(){
    this.setState({open: false});
  },
  _openDropdown: function(){
    this.setState({open: true});
  },

  _setPropsFromChildren: function(){
    var self = this;
    this.toggleLink = cloneWithProps(this.props.children[0], {
      onClick: function(e){
        e.preventDefault();
        self._toggleDropdown();
      }
    });
    this.dropDownList = this.props.children[1];
  },

  renderItems: function(){
    return UF.wrap(dd[1].props.children).map(function(c, index){
      return <Item key={index}>{c}</Item>;
    })
  },

  render: function() {
    var classes = classNames({
      'dropdown': true,
      'open': this.state.open
    });
    this._setPropsFromChildren();
    return (
      <this.props.baseElement className={classes} onMouseOver={this._openDropdown} onMouseOut={this._closeDropdown}>
        {this.toggleLink}
        {this.dropDownList}
      </this.props.baseElement>
    );
  }
})

var Item = React.createClass({
  render: function() {
    return this.props.children;
  }
})

module.exports = Dropdown;