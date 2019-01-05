import * as React from 'react';
import LoginForm from './forms/LoginForm';
import Tools from 'src/utils/helpers/Tools';

type Props = {};

type States = {
    loginFail: boolean
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
        loginFail: false
    };
    async handleSubmit(event) {
        event.preventDefault();
        const response = await Service.handleSubmitLogin(event);
        this.setState({loginFail: !response.ok});
    }

    toggleModal() {
        console.log('Toggle modal');
    }

    render() {
        const {loginFail} = this.state;
        return (
            <div className="container">
                <div className="row">
                    <div className="col-md-8 offset-md-2">
                        <div className="jumbotron">
                            <h2 className="center">LOGIN</h2>
                            <LoginForm formId="loginForm" submitTitle="Login" handleSubmit={this.handleSubmit.bind(this)}>
                                <span className="pointer link" onClick={this.toggleModal}>
                                    Reset password
                                </span>
                            </LoginForm>
                            <ErrorMessage loginFail={loginFail} />
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}

type ErrorMessageProps = {
    loginFail: boolean
};
export const ErrorMessage = ({loginFail}: ErrorMessageProps): React.Node => {
    if (!loginFail) return null;
    return (
        <div className="alert alert-danger" role="alert" style={{marginTop: 16}}>
            Wrong username or password!
        </div>
    );
};
