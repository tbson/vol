import 'formdata-polyfill';
import React from 'react';
import {hot} from 'react-hot-loader';
import ReactDOM from 'react-dom';
import {Router} from 'react-router-dom';
import {APP, History} from 'src/constants';
import Back from './back';
import Front from './front';

const Index = () => <Router history={History}>{APP ? <Back /> : <Front />}</Router>;

ReactDOM.render(<Index />, document.getElementById('app'));
