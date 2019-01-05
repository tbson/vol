import * as React from 'react';

type Props = {
    close: Function
};

export default ({close}: Props) => {
    return (
        <button type="button" className="btn btn-primary" onClick={close}>Cancel</button>
    )
};
