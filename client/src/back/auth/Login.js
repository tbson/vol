// @flow
import * as React from 'react';
// $FlowFixMe: do not complain about importing node_modules
import {withRouter} from 'react-router-dom';
import LoginForm from './forms/LoginForm';
import Tools from 'src/utils/helpers/Tools';
import DefaultModal from 'src/utils/components/modal/DefaultModal';
import ResetPwdForm from './forms/ResetPwdForm';
import type {FormState} from 'src/utils/helpers/Tools';

type Props = {
    history: Object
};

type States = {
    loginFormState: FormState,
    resetPwdModal: boolean
};

export class Service {
    static async handleSubmitLogin(event: Object) {
        const params = Tools.formDataToObj(new FormData(event.target));
        const url = '/api/v1/auth';
        return await Tools.apiCall(url, params, 'POST');
    }
}

export class Login extends React.Component<Props, States> {
    navigateTo: Function;
    state = {
        loginFormState: {
            data: {},
            errors: {}
        },
        resetPwdModal: false
    };

    constructor(props: Props) {
        super(props);
        this.navigateTo = Tools.navigateTo.bind(undefined, props.history);
    }

    componentDidMount() {
        const authData = Tools.getStorageObj('authData');
        if (authData.token) {
            this.navigateTo();
        }
    }

    async handleSubmit(event: Object) {
        event.preventDefault();
        const resp = await Service.handleSubmitLogin(event);
        if (resp.ok) {
            Tools.setStorage('authData', resp.data);
            this.navigateTo();
        } else {
            const {errors} =  resp.data;
            this.setState({loginFormState: {...this.state.loginFormState, errors}});
        }
    }

    toggleModal(open: ?boolean = null) {
        this.setState(state => ({resetPwdModal: open === null ? !state.resetPwdModal : open}));
    }

    render() {
        const {resetPwdModal, loginFormState} = this.state;
        return (
            <>
                <div className="container">
                    <div className="row">
                        <div className="col-md-8 offset-md-2">
                            <div className="jumbotron">
                                <h2 className="center">LOGIN</h2>
                                <LoginForm
                                    formId="loginForm"
                                    submitTitle="Login"
                                    state={loginFormState}
                                    handleSubmit={this.handleSubmit.bind(this)}>
                                    <span className="pointer link" onClick={this.toggleModal.bind(this)}>
                                        Reset password
                                    </span>
                                </LoginForm>
                            </div>
                        </div>
                    </div>
                </div>
                <DefaultModal
                    open={resetPwdModal}
                    title="Reset password"
                    close={() => this.toggleModal.bind(this)(false)}>
                    <ResetPwdForm handleSubmit={() => {}}>
                        <button
                            type="button"
                            className="btn btn-warning"
                            onClick={() => this.toggleModal.bind(this)(false)}>
                            <span className="fas fa-times" />
                            Cancel
                        </button>
                    </ResetPwdForm>
                </DefaultModal>
            </>
        );
    }
}
export default withRouter(Login);
