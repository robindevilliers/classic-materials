import { Renderer } from '../Renderer';
import { Element, isElement } from '../../xml-parser';
import Properties from '../Properties';
import flexItemSupport from '../flex-item-support';
import { flexContainerSupport } from '../flex-container-support';
import { StringBuffer } from '../../utilities/StringBuffer';
import ClassManager from '../ClassManager';
import RenderingEngine from '../RenderingEngine';
import { RenderError } from '../RenderError';

export default class SubMenuRenderer implements Renderer {
    accept(name: string): boolean {
        return name === 'sub-menu';
    }

    render(element: Element, classMappings: Properties, renderingEngine: RenderingEngine): string {

        if (!element.attributes.v) {
            throw new RenderError("Version attribute 'v' not configured against element: " + element.name);
        }

        const children = element.children.filter(el => isElement(el)).map(el => el as Element);

        let label, content = new StringBuffer();
        for (const child of children) {
            if (child.name == 'sub-menu-label') {
                label = renderingEngine.renderElement(child, element);
            } else {
                content.append(renderingEngine.renderElement(child, element));
            }
        }

        const data: Record<string, any> = {};
        data.id = element.attributes.id;
        data.content = content.toString();
        data.hasContent = element.attributes.hasContent === "true";
        data.label = label;

        const classManager = new ClassManager(classMappings);
        flexItemSupport(data, classManager, element.attributes);
        flexContainerSupport(data, classManager, element);
        data.classes = classManager.toString();

        return renderingEngine.render('sub-menu.ftl', data);
    }
}