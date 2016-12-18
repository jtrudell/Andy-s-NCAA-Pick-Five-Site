'use strict';

// materialize
$(document).ready(function(){
  $('.collapsible').collapsible({
    accordion : true
  });
});

$(document).ready(function() {
  $('select').material_select();
});

// Completely unecessary React use for fun
var Headline = React.createClass({
  displayName: 'Headline',

  render: function render() {
    var year = this.props.startYear;
    var endYear = year + 1;

    return React.createElement(
      'div',
      {className: 'headline center'},
      React.DOM.h2(null, 'Andy\'s NCAA Pick Five Challenge'),
      React.createElement(Andy, null),
      React.DOM.h3(null, year + '/' + endYear)
    );
  }
});

var Andy = React.createClass({
  displayName: 'Andy',

  render: function render() {
    return React.createElement(
      'img',
      {className: 'andy circle responsive-image z-depth-3', src: '/andy.jpeg'}
    );
  }
});

var yearParam = window.location.pathname.split('/').pop();
var startYear = function() {
  if (yearParam.length !== 4) {
    return new Date().getFullYear();
  }
  return parseInt(yearParam)
}

ReactDOM.render(
  React.createElement(Headline, {startYear: startYear()}),
  document.querySelector('.headline')
);

