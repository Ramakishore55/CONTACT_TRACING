import { LightningElement, track } from 'lwc';

export default class ConditionalQuestions extends LightningElement {
    @track showFollowUp = false;
    @track showFollowUp1 = false;
    @track showFollowUp2 = false;
    @track selectedValue = '';
    options = [
        { label: 'Yes', value: 'yes' },
        { label: 'No', value: 'no' }
    ];
    options1 = [
        { label: 'వెల్దాం', value: 'వెల్దాం' },
        { label: 'తరువాత వెల్దాం', value: 'తరువాత వెల్దాం' }
    ];
    options2 = [
        { label: 'In DLF', value: 'In DLF' },
        { label: 'Outside', value: 'Outside' }
    ];
    options3 = [
        { label: 'చాలా అవును', value: 'చాలా అవును' },
        { label: 'కొంచెం అవును', value: 'కొంచెం అవును' }
    ];

    handleMainQuestionChange(event) {
        this.selectedValue = event.detail.value;
        this.showFollowUp = this.selectedValue === 'yes';
    }

    handleFollowUpChange(event) {
        console.log('Preferred Coffee Type:', event.target.value);
        if (event.target.value) {
            this.showFollowUp1 = true;
        }
    }

    handleFollowUpChange1(event) {
        console.log('Velaithey 4 matalu kudirethey cup coffee 🙈', event.target.value);
        if (event.target.value) {
            this.showFollowUp2 = true;
        }
    }

    handleFollowUpChange2(event) {
        console.log('Yekada thagudham', event.target.value);
    }
}