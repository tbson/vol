// @flow
import * as React from 'react';

type Props = {
    children?: React.Node,
    submitTitle?: string,
    handleSubmit: Function,
    formId: string
};

export default (props: Props) => {
    const submitTitle = props.submitTitle ?? 'Submit';
    

    return (
        <form id={props.formId} onSubmit={props.handleSubmit}>
            <div className="form-group">
                <label htmlFor="email">Email</label>
                <div className="input-group">
                    <div className="input-group-prepend">
                        <span className="input-group-text">
                            <i className="fas fa-user" />
                        </span>
                    </div>
                    <input
                        id="email"
                        name="email"
                        type="email"
                        className="form-control"
                        required
                        placeholder="Email..."
                    />
                </div>
            </div>

            <div className="form-group">
                <label htmlFor="password">Password</label>
                <div className="input-group">
                    <div className="input-group-prepend">
                        <span className="input-group-text">
                            <i className="fas fa-key" />
                        </span>
                    </div>
                    <input
                        id="password"
                        name="password"
                        type="password"
                        className="form-control"
                        required
                        placeholder="Password..."
                    />
                </div>
            </div>

            <div className="right">
                {props.children}
                &nbsp;&nbsp;
                <button type="submit" className="btn btn-primary">
                    <span className="fas fa-check" />
                    &nbsp;
                    {submitTitle}
                </button>
            </div>
        </form>
    );
};
