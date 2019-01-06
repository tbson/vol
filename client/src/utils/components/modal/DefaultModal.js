// @flow
import * as React from 'react';
import CustomModal from 'src/utils/components/modal/CustomModal';

type Props = {
    open: boolean,
    title: string,
    size?: string,
    heading?: boolean,
    close: Function,
    children: React.Node
};

export class Service {
    static handleEsc(open: boolean, callback: Function) {
        return (event: Object) => {
            event = event || window.event;
            event.keyCode == 27 && open && callback();
        };
    }

    static listentEsc(open: boolean, callback: Function) {
        open && window.document.addEventListener('keydown', Service.handleEsc(open, callback), {once: true});
    }
}

export default ({open = false, size = 'md', heading = true, title = '', close, children}: Props) => {
    Service.listentEsc(open, close);
    return open ? (
        <CustomModal open={true} close={close} title={title} size={size} heading={heading}>
            <div className="modal-inner">
                {/* $FlowFixMe: No Type for cloneElement */}
                {React.cloneElement(children, {close})}
            </div>
        </CustomModal>
    ) : null;
};
