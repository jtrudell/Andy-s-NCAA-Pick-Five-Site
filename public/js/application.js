'use strict';

// title
var yearParam = window.location.pathname.split('/').pop();
var startYear = function() {
  if (yearParam.length !== 4) {
    return new Date().getFullYear();
  }
  return parseInt(yearParam)
}

var Headline = React.createClass({
  displayName: 'Headline',

  render: function render() {
    var endYear = startYear() + 1;

    return React.createElement(
      'div',
      {className: 'headline center'},
      React.DOM.h1(null, 'NCAA Pick Five Challenge'),
      React.DOM.h2(null, startYear() + '/' + endYear )
    );
  }
});

// this is completely unecessary and for experimentation
Headline.defaultProps = {
  startYear: startYear()
};

ReactDOM.render(
  React.createElement(Headline, null),
  document.querySelector('.headline')
);

// materialize
$(document).ready(function(){
  $('.collapsible').collapsible({
    accordion : true
  });
});
