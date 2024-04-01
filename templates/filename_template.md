<%*
let templater      = app.plugins.plugins["templater-obsidian"];
let templateFolder = templater.settings.templates_folder;

/**
 * format:   momentjs format strings for filename
 * template: name of template
 * 
 * If the file name matches the format, respective
 * template will be inserted.
 */
checker = 0;

let noteTypes = [
    {format: "YYYY-MM-DD",     template: "Daily Template.md"},
    {format: "gggg-[W]ww",     template: "Weekly Template.md"},
    {format: "YYYY-MM",     template: "Monthly Template.md"},
    {format: "YYYY-[Q]Q",     template: "Quarterly Template.md"},
    {format: "YYYY",     template: "Yearly Template.md"},
    {format: "YYYY-MMDD-HHmm", template: "unique-note.md"},
    // ...etc
];

for (const noteType of noteTypes) {

    // If found a matching note title
    if (moment(tp.file.title,
               noteType.format,
               true)
        .isValid()) {

        // Get TFile of template
        let templateTFile;
        try {
            // Get TFile
            templateTFile = app.vault.getAbstractFileByPath(
                `${templateFolder}/${noteType.template}`
            );

            // Error handling
            if (!templateTFile) {
                let msg = "Template not found\n" +
                          `${templateFolder}/${noteType.template} does not exist.`;
                new Notice(msg);
                throw Error(msg);
            }
        } catch (e) {
            console.error(e);
            return;
        }
        checker = 1;
        // Insert template
        templater.templater.append_template_to_active_file(
            templateTFile
        );
    } 
 
    
}
if (checker==0) {
	let templateTFile;
	try {
		// Get TFile
		templateTFile = app.vault.getAbstractFileByPath(
			`${templateFolder}/Default 1.md`
		);
	
		// Error handling
		if (!templateTFile) {
			let msg = "Template not found\n" +
					  `${templateFolder}/Default 1.md does not exist.`;
			new Notice(msg);
			throw Error(msg);
		}
	} catch (e) {
		console.error(e);
		return;
	}
	// Insert template
	templater.templater.append_template_to_active_file(
		templateTFile
	);
}   
-%>
