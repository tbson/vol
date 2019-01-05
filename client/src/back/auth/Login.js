import * as React from 'react';
import LoginForm from './forms/LoginForm';
import Tools from 'src/utils/helpers/Tools';
import DefaultModal from 'src/utils/components/modal/DefaultModal';
import ResetPwdForm from './forms/ResetPwdForm';

type Props = {};

type States = {
    loginFail: boolean,
    resetPwdModal: boolean
};

export class Service {
    static async handleSubmitLogin(event: Object) {
        const params = Tools.formDataToObj(new FormData(event.target));
        const url = '/api/v1/auth';
        return await Tools.apiCall(url, params, 'POST');
    }
}

export default class Login extends React.Component<Props, States> {
    state = {
        loginFail: false,
        resetPwdModal: false
    };

    async handleSubmit(event) {
        event.preventDefault();
        const resp = await Service.handleSubmitLogin(event);
        resp.ok ? Tools.setStorage('authData', resp.data) : this.setState({loginFail: !resp.ok});
    }

    toggleModal(open = null) {
        this.setState(state => ({resetPwdModal: open === null ? !state.resetPwdModal : open}));
    }

    render() {
        const {resetPwdModal, loginFail} = this.state;
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
                                    handleSubmit={this.handleSubmit.bind(this)}>
                                    <span className="pointer link" onClick={this.toggleModal.bind(this)}>
                                        Reset password
                                    </span>
                                </LoginForm>
                                <ErrorMessage loginFail={loginFail} />
                            </div>
                        </div>
                    </div>
                </div>
                <DefaultModal open={resetPwdModal} title="Test" close={() => this.toggleModal.bind(this)(false)}>
                    <ResetPwdForm />
                </DefaultModal>
            </>
        );
    }
}

type ErrorMessageProps = {
    loginFail: boolean
};

export const ErrorMessage = ({loginFail}: ErrorMessageProps) =>
    loginFail ? (
        <div className="alert alert-danger" role="alert" style={{marginTop: 16}}>
            Wrong username or password!
        </div>
    ) : null;
