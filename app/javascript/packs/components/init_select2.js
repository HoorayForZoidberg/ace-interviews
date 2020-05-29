import $ from 'jquery';
import 'select2';

const initSelect2 = (selector, options = {}) => {
  $(selector).select2(options);
};

export { initSelect2 };
