import { Renderer } from '../Renderer';
import { Element } from '../../xml-parser';
import Properties from '../Properties';
import { flexContainerSupport } from '../flex-container-support';
import ClassManager from '../ClassManager';
import RenderingEngine from '../RenderingEngine';

export default class EmailRenderer implements Renderer {
    accept(name: string): boolean {
        return name === 'email';
    }

    render(element: Element, classMappings: Properties, renderingEngine: RenderingEngine): string {

        const data: Record<string, any> = {};

        data.id = element.attributes.id;
        data.content = renderingEngine.renderChildren(element);

        const classManager = new ClassManager(classMappings);
        flexContainerSupport(data, classManager, element);
        data.classes = classManager.toString();

        return renderingEngine.render('email.ftl', data);
    }
}
