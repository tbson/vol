// @flow
import * as React from 'react';
// $FlowFixMe: do not complain about importing node_modules
import {hot} from 'react-hot-loader';
// $FlowFixMe: do not complain about importing node_modules
import {Switch, Route} from 'react-router-dom';
// $FlowFixMe: do not complain about importing node_modules
import 'bootstrap/dist/css/bootstrap.min.css';
// $FlowFixMe: do not complain about importing node_modules
import(/* webpackPreload: true */ '@fortawesome/fontawesome-free/css/all.css');
// $FlowFixMe: do not complain about importing node_modules
import {ToastContainer} from 'react-toastify';
// $FlowFixMe: do not complain about importing node_modules
import(/* webpackPreload: true */ 'rummernote/build/bs4/style.css');
// $FlowFixMe: do not complain about importing node_modules
import(/* webpackPreload: true */ 'bootstrap/dist/js/bootstrap');

import 'src/utils/styles/main-back.css';
import Spinner from 'src/utils/components/spinner';
import NotMatch from 'src/utils/components/route/NotMatch';
import Tools from 'src/utils/helpers/Tools';

import Trans from 'src/utils/helpers/Trans';
import translations from 'src/utils/translations.json';

type Props = {};

class App extends React.Component<Props> {
    constructor(props: Props) {
        super(props);
        Trans.initTranslations(translations);
    }

    render() {
        return (
            <div>
                <Spinner />
                <ToastContainer autoClose={5000} />
                <Switch>
                    <Route exact path="/" component={Back} />
                    <Route component={NotMatch} />
                </Switch>
            </div>
        );
    }
}

function Back() {
    return <h1>Back</h1>
}

export default hot(module)(App);
