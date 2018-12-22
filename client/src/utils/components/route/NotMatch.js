// @flow
import * as React from 'react';
import NavWrapper from '../nav_wrapper';

type Props = {};
class NotMatch extends React.Component<Props> {
    render() {
        return (
            <NavWrapper>
                <h1>Page not found</h1>
            </NavWrapper>
        );
    }
}

export default NotMatch;
