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
    formState: FormState,
    modal: boolean
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
        formState: {
            data: {},
            errors: {}
        },
        modal: false
    };

    constructor(props: Props) {
        super(props);
        this.navigateTo = Tools.navigateTo.bind(undefined, props.history);
    }

    componentDidMount() {
        Tools.getToken() && this.navigateTo();
    }

    async handleSubmit(event: Object) {
        event.preventDefault();
        const resp = await Service.handleSubmitLogin(event);

        if (resp.ok) {
            Tools.setStorage('auth', resp.data) || this.navigateTo();
        } else {
            this.setState(Tools.setFormErrors(resp.data.errors));
        }
    }

    toggleModal(open: ?boolean = null) {
        this.setState(Tools.toggleState(open));
    }

    render() {
        const {modal, formState} = this.state;
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
                                    state={formState}
                                    handleSubmit={this.handleSubmit.bind(this)}>
                                    <span className="pointer link" onClick={this.toggleModal.bind(this)}>
                                        Reset password
                                    </span>
                                </LoginForm>
                            </div>
                        </div>
                    </div>
                </div>
                <ResetPwdModal open={modal} close={() => this.toggleModal.bind(this)(false)} />
            </>
        );
    }
}
export default withRouter(Login);

type ResetPwdModalType = {
    open: boolean,
    close: Function
};
export const ResetPwdModal = ({open, close}: ResetPwdModalType) => {
    return (
        <DefaultModal open={open} title="Reset password" close={close}>
            <ResetPwdForm handleSubmit={() => {}}>
                <button type="button" className="btn btn-warning" onClick={close}>
                    <span className="fas fa-times" />
                    Cancel
                </button>
            </ResetPwdForm>
        </DefaultModal>
    );
};
