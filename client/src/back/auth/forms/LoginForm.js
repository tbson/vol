// @flow
import * as React from 'react';
import Tools from 'src/utils/helpers/Tools';
import TextInput from 'src/utils/components/input/TextInput';
import type {FormState} from 'src/utils/helpers/Tools';

type Props = {
    handleSubmit: Function,
    children?: React.Node,
    submitTitle: string,
    state: FormState
};
export default ({handleSubmit, children, state, submitTitle = 'Submit'}: Props) => {
    const name = 'login';
    const id = Tools.getFieldId.bind(undefined, name);
    return (
        <form name={name} onSubmit={handleSubmit}>
            <TextInput id={id('email')} type="email" label="Email" required={true} autoFocus={true} />

            <TextInput id={id('password')} type="password" label="Password" required={true} />

            <ErrorMessage error={state.errors?.error} />

            <ButtonsBar children={children} submitTitle={submitTitle} />
        </form>
    );
};

type ButtonBarProps = {
    children?: React.Node,
    submitTitle: string
};
export const ButtonsBar = ({children, submitTitle}: ButtonBarProps) => {
    return (
        <div className="row">
            <div className="col">{children}</div>
            <div className="col right">
                <button type="submit" className="btn btn-primary">
                    <span className="fas fa-check" />
                    {submitTitle}
                </button>
            </div>
        </div>
    );
};

type ErrorMessageProps = {
    error: string
};

export const ErrorMessage = ({error}: ErrorMessageProps) =>
    error ? (
        <div className="alert alert-danger" role="alert" style={{marginTop: 16}}>
            Wrong username or password!
        </div>
    ) : null;
