// @flow
import * as React from 'react';

type Props = {
    errors: Array<string>
};

export default ({errors}: Props) => {
    const errorItems = errors => errors.map((error, key) => <li key={key}>{error}</li>);
    const errorItem = error => <div>{error}</div>;
    return Array.isArray(errors) ? (
        <div className="invalid-feedback">
            {errors.length === 1 ? errorItem(errors[0]) : <ul>{errorItems(errors)}</ul>}
        </div>
    ) : null;
};
